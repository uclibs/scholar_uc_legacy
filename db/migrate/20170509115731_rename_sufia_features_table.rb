class RenameHyraxFeaturesTable < ActiveRecord::Migration
  def change
    rename_table :hyrax_features, :hyrax_features
  end
end
