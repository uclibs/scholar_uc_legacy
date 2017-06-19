# frozen_string_literal: true
module SeedMethods
  def self.new_article(email, name)
    a = Article.create(
      title: ['This is the title'],
      description: ['This is the abstract'],
      depositor: email,
      owner: email,
      creator: [name],
      subject: populate_subject,
      publisher: ['Penguin Publishing'],
      issn: [123_456_789],
      language: ['English'],
      based_near: ['The world'],
      time_period: ['Now'],
      required_software: 'This requires software',
      note: 'This is the note',
      date_created: [populate_date_created]
    )
    a.read_groups = [Hydra::AccessControls::AccessRight::PERMISSION_TEXT_VALUE_PUBLIC]
    a.edit_users = [email]
    a.save
  end

  def self.new_image(email, name)
    a = Image.create(
      title: ['This is the title'],
      description: ['This is the description'],
      depositor: email,
      owner: email,
      creator: [name],
      subject: populate_subject,
      publisher: ['Penguin Publishing'],
      geo_subject: ['The world'],
      time_period: ['Now'],
      source: ['This is the source'],
      required_software: 'This requires software',
      date_created: [populate_date_created]
    )
    a.read_groups = [Hydra::AccessControls::AccessRight::PERMISSION_TEXT_VALUE_PUBLIC]
    a.edit_users = [email]
    a.save
  end

  def self.new_document(email, name)
    a = Document.create(
      title: ['This is the title'],
      description: ['This is the description'],
      depositor: email,
      owner: email,
      creator: [name],
      subject: populate_subject,
      publisher: ['Penguin Publishing'],
      language: ['English'],
      required_software: 'This requires software',
      date_created: [populate_date_created]
    )
    a.read_groups = [Hydra::AccessControls::AccessRight::PERMISSION_TEXT_VALUE_PUBLIC]
    a.edit_users = [email]
    a.save
  end

  def self.new_dataset(email, name)
    a = Dataset.create(
      title: ['This is the title'],
      description: ['This is the description'],
      depositor: email,
      owner: email,
      creator: [name],
      subject: populate_subject,
      publisher: ['Penguin Publishing'],
      alternate_title: ['This is the alternate title'],
      language: ['English'],
      based_near: ['The world'],
      time_period: ['Now'],
      required_software: 'This requires software',
      note: 'This is the note',
      date_created: [populate_date_created]
    )
    a.read_groups = [Hydra::AccessControls::AccessRight::PERMISSION_TEXT_VALUE_PUBLIC]
    a.edit_users = [email]
    a.save
  end

  def self.new_genericwork(email, name)
    a = GenericWork.create(
      title: ['This is the title'],
      description: ['This is the description'],
      depositor: email,
      owner: email,
      creator: [name],
      subject: populate_subject,
      publisher: ['Penguin Publishing'],
      alternate_title: ['This is the alternate title'],
      language: ['English'],
      based_near: ['The world'],
      time_period: ['Now'],
      required_software: 'This requires software',
      note: 'This is the note',
      date_created: [populate_date_created]
    )
    a.read_groups = [Hydra::AccessControls::AccessRight::PERMISSION_TEXT_VALUE_PUBLIC]
    a.edit_users = [email]
    a.save
  end

  def self.new_medium(email, name)
    a = Medium.create(
      title: ['This is the title'],
      description: ['This is the description'],
      depositor: email,
      owner: email,
      creator: [name],
      subject: populate_subject,
      publisher: ['Penguin Publishing'],
      alternate_title: ['This is the alternate title'],
      language: ['English'],
      based_near: ['The world'],
      time_period: ['Now'],
      required_software: 'This requires software',
      note: 'This is the note',
      date_created: [populate_date_created]
    )
    a.read_groups = [Hydra::AccessControls::AccessRight::PERMISSION_TEXT_VALUE_PUBLIC]
    a.edit_users = [email]
    a.save
  end

  def self.new_account(email, name, pass)
    user = User.create(email: email, first_name: first_name(name), last_name: last_name(name), password: pass, password_confirmation: pass)
    user.save!
  end

  def self.first_name(name)
    name.split(" ")[0]
  end

  def self.last_name(name)
    name.split(" ")[1]
  end

  # this method populates the subject field of a work with a random array of 2-3 elements
  # the variation in elements in the array is intentional as any work type should be able
  # to support a variable number of elements
  def self.populate_subject
    sample_subjects = ['geography', 'history', 'chemistry', 'research', 'biology', 'technology']
    ret = []
    3.times do
      sample_subject = sample_subjects.sample
      ret.push sample_subject unless ret.include?(sample_subject)
    end
    ret
  end

  # generates random date from epoch to now as string
  def self.populate_date_created
    Time.zone.at(rand * Time.now.to_i).to_s.sub(/\s(.*)/, '')
  end
end
