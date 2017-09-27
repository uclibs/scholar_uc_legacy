class LinkedResourcesReport < Report

  private

  def self.report_objects
    LinkedResource.all
  end

  def self.fields(resource = LinkedResource.new)
    [ 
      { pid: resource.pid },
      { owner: resource.owner },
      { depositor: resource.depositor },
      { edit_users: resource.edit_users.join(" ") }
    ]
  end
end

