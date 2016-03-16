module SeedMethods

  def self.new_article(email, name)
    a = Article.create(title: "This is the title", abstract: "This is the abstract", depositor: email, owner: email, creator: name)
    a.read_groups = [Hydra::AccessControls::AccessRight::PERMISSION_TEXT_VALUE_PUBLIC]
    a.save
  end

  def self.new_image(email, name)
    a = Image.create(title: "This is the title", depositor: email, owner: email, creator: name)
    a.read_groups = [Hydra::AccessControls::AccessRight::PERMISSION_TEXT_VALUE_PUBLIC]
    a.save
  end

  def self.new_document(email, name)
    a = Document.create(title: "This is the title", depositor: email, owner: email, creator: name)
    a.read_groups = [Hydra::AccessControls::AccessRight::PERMISSION_TEXT_VALUE_PUBLIC]
    a.save
  end

  def self.new_dataset(email, name)
    a = Dataset.create(title: "This is the title", depositor: email, owner: email, creator: name)
    a.read_groups = [Hydra::AccessControls::AccessRight::PERMISSION_TEXT_VALUE_PUBLIC]
    a.save
  end

  def self.new_genericwork(email, name)
    a = GenericWork.create(title: "This is the title", depositor: email, owner: email, creator: name)
    a.read_groups = [Hydra::AccessControls::AccessRight::PERMISSION_TEXT_VALUE_PUBLIC]
    a.save
  end

  def self.new_video(email, name)
    a = Video.create(title: "This is the title", depositor: email, owner: email, creator: name)
    a.read_groups = [Hydra::AccessControls::AccessRight::PERMISSION_TEXT_VALUE_PUBLIC]
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

end
