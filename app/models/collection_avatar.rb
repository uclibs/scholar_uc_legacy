# frozen_string_literal: true
class CollectionAvatar < ApplicationRecord
  mount_uploader :avatar, Scholar::CollectionAvatarUploader
end
