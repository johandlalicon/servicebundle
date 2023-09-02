class RenamePasswordToPasswordDigestInMerchants < ActiveRecord::Migration[7.0]
  def change
    rename_column :merchants, :password, :password_digest
  end
end
