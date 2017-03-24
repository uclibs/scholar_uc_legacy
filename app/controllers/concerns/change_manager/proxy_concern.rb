module ChangeManager
  module ProxyConcern
    extend ActiveSupport::Concern

    define_method(:send_proxy_depositor_added_messages) do |grantor, grantee|
      message_to_grantee = "#{grantor.name} has assigned you as a proxy depositor"
      message_to_grantor = "You have assigned #{grantee.name} as a proxy depositor"
      ::User.batch_user.send_message(grantor, message_to_grantor, "Proxy Depositor Added")
      ::User.batch_user.send_message(grantee, message_to_grantee, "Proxy Depositor Added")
      send_granted_proxy_email(grantor, grantee)
    end

    define_method(:destroy) do
      grantor = authorize_and_return_grantor
      grantee = ::User.from_url_component(params[:id])
      send_removed_proxy_email(grantor, grantee) if grantor.can_receive_deposits_from.delete(grantee)
      head :ok
    end

    define_method(:send_granted_proxy_email) do |grantor, grantee|
      EmailManager.queue_change(grantor, 'added_as_proxy', '', grantee)
    end

    define_method(:send_removed_proxy_email) do |grantor, grantee|
      EmailManager.queue_change(grantor, 'removed_as_proxy', '', grantee)
    end
  end
end
