# == Schema Information
#
# Table name: verbs
#
#  id            :integer          not null, primary key
#  content       :string(255)
#  group         :string(255)
#  employ        :text
#  auxiliary     :text
#  definition    :text
#  created_at    :datetime
#  updated_at    :datetime
#  first_letter  :string(255)
#  page_content  :text
#  html_name     :string(255)
#  letters_count :integer          default(0)
#  research_name :text
#
class Verb < ActiveRecord::Base

  validates :content, presence: true
  validates :content, uniqueness: { case_sensitive: false }
  after_create :update_html_name
  after_create :update_research_name
  after_create :update_first_letter
  after_create :update_letters_count

  before_create :normalize_content

  has_many :synonymings
  has_many :synonyms, :through => :synonymings
  has_many :tense_entries

  include AlertableMethods

  extend FriendlyId
  friendly_id :content, use: :slugged
  
  def self.filter(attributes)
    attributes.inject(self) do |scope, (key, value)|
    #return scope.scoped if value.blank?
      if value.blank?
      scope.all
      else
        case key.to_sym
        when :starting_letter
          scope.where('verbs.first_letter = ?', "#{value}")
        when :number_letter# regexp search
          scope.where('verbs.letters_count = ?', "#{value}")
        else # unknown key (do nothing or raise error, as you prefer to)
        scope.all
        end
      end
    end
  end

  def get_tense_entries(tense_id)
    self.tense_entries.where('tense_entries.tense_id = ?', tense_id)
  end

  def html_name_bis
    string = I18n.transliterate(self.content)
    string = string.strip
    string = string.gsub(' ', '_')
    return string
  end

  # Convert the content in Nokogiri Nodes
  def page_content_to_html
    html = Nokogiri::HTML(self.page_content)
  end

  # Get the first letter.
  def start_letter
    return self.content.first
  end

  # Number of letter of content
  def count_letter
    return self.content.length
  end

  # For the research without accent
  def get_research_name
    return I18n.transliterate(self.content.to_s.strip)
  end

  # Transform the name into a URL compatible name
  def get_html_name
    string = I18n.transliterate(self.content)
    string = string.strip
    string = string.gsub(' ', '+')
    return string
  end

  # UPdate starting letteer
  def self.update_small_fields
    self.find_each do |verb|
      puts verb.id.to_s
      first_letter = verb.start_letter
      new_name = verb.get_html_name
      verb.update(:first_letter => first_letter, :html_name => new_name, :letters_count => verb.count_letter, :research_name => verb.get_research_name)
    end
  end

  def get_group_verb
    html = self.page_content_to_html
    part = html.css('div.verbe nav b')
    if !part.first.nil?
      group =  part.first.text
      if group.match('premier')
        return "1"
      elsif group.match('deuxi')
        return "2"
      elsif group.match('troisi')
        return "3"
      else
        return "error"
      end
    else
      return "inconnu"
    end
  end

  def self.update_group_verb
    self.find_each do |verb|
      puts verb.id.to_s
      group = verb.get_group_verb
      verb.update(:group => group)
    end
  end

  def get_auxiliary_verb
    html = self.page_content_to_html
    part = html.css('div.verbe nav')
    if !part.nil?
      string = part.to_html.split("<br>")[1]
    return string.to_s
    else
      return "error"
    end
  end

  def self.update_auxiliary_verb
    self.find_each do |verb|
      puts verb.id.to_s
      auxi = verb.get_auxiliary_verb
      verb.update(:auxiliary  => auxi)
    end
  end

  def get_synonyms
    html = self.page_content_to_html
    get_part = html.css('h3:eq(2) + p')
    verbs = get_part.css('a')
    verbs.each do |v|
      text = v.text
      verb = Verb.find_or_create_by(content: text)
      if !verb.nil?
        if !self.synonyms.exists?(verb)
        self.synonyms << verb
        end
      else
        puts text.to_s
      end
    end
  end

  def self.update_synonyms
    self.find_each do |verb|
      puts verb.id.to_s
      verb.get_synonyms
    end
  end

  def get_employ
    html = self.page_content_to_html
    get_part = html.css('h3:eq(3)')
    if !get_part.text.nil?
      if get_part.text.match('Emploi du verbe')
        return get_employ = html.css('h3:eq(3) + p').text
      elsif get_part.text.match('Définition du verbe')
        get_next = html.css('h3:eq(4)')
        if get_next.text.match('Emploi du verbe')
          return html.css('h3:eq(4) + p').text
        else
          return nil
        end
      end
    else
      return nil
    end
  end

  def self.update_employ_verb
    self.find_each do |verb|
      puts verb.id.to_s
      employ = verb.get_employ
      verb.update(:employ => employ)
    end
  end

  def get_definition_conjugeur
    html = self.page_content_to_html
    get_part = html.css('h3:eq(3)')
    if !get_part.text.nil?
      if get_part.text.match('Définition du verbe')
        return get_employ = html.css('h3:eq(3) + p').text
      else
        return nil
      end
    else
      return nil
    end
  end

  def self.update_definition_verb
    self.find_each do |verb|
      puts verb.id.to_s
      definition = verb.get_definition_conjugeur
      if !definition.nil?
        verb.update(:definition => definition)
      end
    end
  end

  def fill_tenses
    html = self.page_content_to_html
    Tense.find_each do |tensemodel|
      m = tensemodel.markup
      selector = '#' + m + ' + p'
      tense = html.css(selector)
      if !tense.nil?
        text = tense.to_html
        tab = text.gsub(/<\/?p>/, '').split('<br>')
        i = 1
        tab.each do |entry|
          new_entry = TenseEntry.new(:total_content => entry.to_s, :order => i)
          self.tense_entries << new_entry
          tensemodel.tense_entries << new_entry
          i += 1
        end
      end
    end
  end

  def self.get_all_tenses
    self.find_each do |verb|
      puts verb.id.to_s
      html = verb.page_content_to_html
      Tense.find_each do |tensemodel|
        selector = '#' + tensemodel.markup.to_s + ' + p'
        tense = html.css(selector)
        if !tense.nil?
          tab = tense.to_html.gsub(/<\/?p>/, '').split('<br>')
          i = 1
          tab.each do |entry|
            new_entry = TenseEntry.new(:total_content => entry.to_s, :order => i)
            verb.tense_entries << new_entry
            tensemodel.tense_entries << new_entry
            i += 1
          end
        end
      end
    end
  end

  def get_tense
    html = self.page_content_to_html
    tenses = html.css('div.tempsBloc')
    i = 0
    tenses.each do |t|
      id = t['id']
      name = t.css('p').text

      if i < 8
        mode = Mode.find_by_name('Indicatif')
      entry_type = 1
      elsif i < 12
        mode = Mode.find_by_name('Subjonctif')
      entry_type = 1
      elsif i < 15
        mode = Mode.find_by_name('Conditionnel')
      entry_type = 1
      elsif i < 17
        mode = Mode.find_by_name('Impératif')
      entry_type = 2
      elsif i < 19
        mode = Mode.find_by_name('Participe')
      entry_type = 2
      elsif i < 21
        mode = Mode.find_by_name('Infinitif')
      entry_type = 2
      elsif i < 23
        mode = Mode.find_by_name('Gérondif')
      entry_type = 2
      elsif i < 25
        mode = Mode.find_by_name('Tournures')
      entry_type = 1
      end
      tense = Tense.new(:name => name, :markup => id.to_s, :entry_type => entry_type)
      mode.tenses << tense

      i += 1
    end
  end

  def self.global_update
    self.find_each do |verb|
      puts verb.id.to_s
      verb.get_synonyms
      verb.fill_tenses
    end
  end

  def similar_verbs
    verbs = Verb.similar_verbs(self.content.to_s)
    return verbs - [self]
  end

  def self.similar_verbs(verb)
    string = verb.strip.to_s
    length = string.length

    if length > 4

      string1 = string.chop
      string2 = string1.chop
      string3 = string2.chop

      verb1 = Verb.where('content ilike ?', "#{string1}_%").limit(10)
      verb2 = Verb.where('content ilike ?', "#{string2}_%").limit(10)
      verb3 = Verb.where('content ilike ?', "#{string3}_%").limit(10)

    verbs = verb1 + verb2 + verb3
    return verbs.uniq
    else
    return []
    end
  end

  private

  # Normalize the string
  def normalize_content
    self.content = self.content.to_s.strip.downcase
  end

  def update_letters_count
    self.update(:letters_count => self.count_letter)
  end

  def update_html_name
    new_name = self.get_html_name
    self.update(:html_name => new_name)
  end

  def update_research_name
    res_name = self.get_research_name
    self.update(:research_name => res_name)
  end

  def update_first_letter
    first_letter = self.start_letter
    self.update(:first_letter => first_letter)
  end

end
