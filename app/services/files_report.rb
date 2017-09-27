class FilesReport < Report

  private

  def self.report_objects
    GenericFile.all
  end

  def self.fields(file = GenericFile.new)
    [ 
      { pid: file.pid },
      { title: file.label },
      { filename: file.filename },
      { owner: file.owner },
      { depositor: file.depositor },
      { edit_users: file.edit_users.join(" ") },
    ]
  end
end

