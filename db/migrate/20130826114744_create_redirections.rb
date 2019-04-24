class CreateRedirectionsRedirections < ActiveRecord::Migration[5.1]
  def up
    create_table :refinery_redirections do |t|
      t.string :from_url
      t.string :to_url
      t.integer :status_code, default: 301

      t.timestamps
    end
  end

  def down
    if defined?(::Refinery::UserPlugin)
      ::Refinery::UserPlugin.destroy_all(name: 'refinerycms-redirections')
    end

    if defined?(::Refinery::Page)
      ::Refinery::Page.delete_all(link_url: '/redirections/redirections')
    end

    drop_table :refinery_redirections
  end
end
