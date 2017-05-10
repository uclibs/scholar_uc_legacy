class RenameSufiaFeaturesTable < ActiveRecord::Migration
  def change
    rename_table :sufia_features, :hyrax_features
  end
end
