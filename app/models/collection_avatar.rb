# frozen_string_literal: true
class CollectionAvatar < ActiveRecord::Base
  mount_uploader :avatar, Sufia::AvatarUploader
end
