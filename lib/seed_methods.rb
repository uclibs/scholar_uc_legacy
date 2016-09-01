module SeedMethods

  def self.new_article(email, name)
    a = Article.create(
      title: 'This is the title', 
      abstract: 'This is the abstract', 
      depositor: email, 
      owner: email, 
      creator: name,
      subject: populate_subject,
      publisher: 'Penguin Publishing',
      alternate_title: 'This is the alternate title',
      journal_title: 'This is the journal title',
      issn: 123456789,
      language: 'English',
      coverage_spatial: 'The world',
      coverage_temporal: 'Now',
      bibliographic_citation: 'This is the bibliographic citation',
      requires: 'This requires software',
      note: 'This is the note',
      date_created: populate_date_created
      )
    a.read_groups = [Hydra::AccessControls::AccessRight::PERMISSION_TEXT_VALUE_PUBLIC]
    a.edit_users = [email]
    a.save
  end

  def self.new_image(email, name)
    a = Image.create(
      title: 'This is the title',
      description: 'This is the description',
      depositor: email, 
      owner: email, 
      creator: name,
      subject: populate_subject,
      publisher: 'Penguin Publishing',
      alternate_title: 'This is the alternate title',
      coverage_temporal: 'Now',
      coverage_spatial: 'This is the geographic_subject',
      bibliographic_citation: 'This is the bibliographic citation',
      date_photographed: '1900',
      source: 'This is the source',
      requires: 'This requires software',
      note: 'This is the note',
      genre: 'Painting',
      location: 'El mundo',
      cultural_context: 'The culture',
      measurements: '15x16x1',
      material: 'paper',
      date_created: populate_date_created
      )
    a.read_groups = [Hydra::AccessControls::AccessRight::PERMISSION_TEXT_VALUE_PUBLIC]
    a.edit_users = [email]
    a.save
  end

  def self.new_document(email, name)
    a = Document.create(
      title: 'This is the title',
      description: 'This is the description',
      depositor: email, 
      owner: email, 
      creator: name,
      subject: populate_subject,
      publisher: 'Penguin Publishing',
      alternate_title: 'This is the alternate title',
      genre: 'Book',
      language: 'English',
      coverage_spatial: 'The world',
      coverage_temporal: 'Now',
      bibliographic_citation: 'This is the bibliographic citation',
      requires: 'This requires software',
      note: 'This is the note',
      date_created: populate_date_created
      )
    a.read_groups = [Hydra::AccessControls::AccessRight::PERMISSION_TEXT_VALUE_PUBLIC]
    a.edit_users = [email]
    a.save
  end

  def self.new_dataset(email, name)
    a = Dataset.create(
      title: 'This is the title',
      description: 'This is the description',
      depositor: email,
      owner: email,
      creator: name,
      subject: populate_subject,
      publisher: 'Penguin Publishing',
      alternate_title: 'This is the alternate title',
      language: 'English',
      coverage_spatial: 'The world',
      coverage_temporal: 'Now',
      bibliographic_citation: 'This is the bibliographic citation',
      requires: 'This requires software',
      note: 'This is the note',
      date_created: populate_date_created
      )
    a.read_groups = [Hydra::AccessControls::AccessRight::PERMISSION_TEXT_VALUE_PUBLIC]
    a.edit_users = [email]
    a.save
  end

  def self.new_genericwork(email, name)
    a = GenericWork.create(
      title: 'This is the title',
      description: 'This is the description',
      depositor: email, 
      owner: email, 
      creator: name,
      subject: populate_subject,
      publisher: 'Penguin Publishing',
      alternate_title: 'This is the alternate title',
      language: 'English',
      coverage_spatial: 'The world',
      coverage_temporal: 'Now',
      bibliographic_citation: 'This is the bibliographic citation',
      requires: 'This requires software',
      note: 'This is the note',
      date_created: populate_date_created
      )
    a.read_groups = [Hydra::AccessControls::AccessRight::PERMISSION_TEXT_VALUE_PUBLIC]
    a.edit_users = [email]
    a.save
  end

  def self.new_video(email, name)
    a = Video.create(
      title: 'This is the title', 
      description: 'This is the description',
      depositor: email, 
      owner: email, 
      creator: name,
      subject: populate_subject,
      publisher: 'Penguin Publishing',
      alternate_title: 'This is the alternate title',
      date_digitized: '2015',
      language: 'English',
      coverage_spatial: 'The world',
      coverage_temporal: 'Now',
      bibliographic_citation: 'This is the bibliographic citation',
      requires: 'This requires software',
      note: 'This is the note',
      date_created: populate_date_created
      )
    a.read_groups = [Hydra::AccessControls::AccessRight::PERMISSION_TEXT_VALUE_PUBLIC]
    a.edit_users = [email]
    a.save
  end

 
  def self.new_account(email, name, pass)
    user = User.create user_does_not_require_profile_update: true, email: email, first_name: first_name(name), last_name: last_name(name), password: pass, password_confirmation: pass
    profile = Profile.new depositor: email
    profile.apply_depositor_metadata(user.user_key)
    profile.read_groups = [Hydra::AccessControls::AccessRight::PERMISSION_TEXT_VALUE_PUBLIC]
    profile.save!
    person = Person.new depositor: email, email: email, profile: profile, first_name: first_name(name), last_name: last_name(name)
    person.apply_depositor_metadata(user.user_key)
    person.read_groups = [Hydra::AccessControls::AccessRight::PERMISSION_TEXT_VALUE_PUBLIC]
    person.save!
    user.repository_id = person.pid
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
    for i in 1..3
      sample_subject = sample_subjects.sample
      unless ret.include?(sample_subject)
        ret.push sample_subject
      end
    end
    ret
  end

  # generates random date from epoch to now as string
  def self.populate_date_created
    Time.at(rand * Time.now.to_i).to_s.sub(/\s(.*)/, '')
  end

end
