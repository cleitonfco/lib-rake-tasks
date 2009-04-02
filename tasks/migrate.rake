namespace(:db) do
  namespace(:migrate) do
    desc('Migrate test databases through scripts in db/migrate. Target specific version with VERSION=x.')
    task(:test => :environment) do
      puts("Migrating test environment...")
      system("rake RAILS_ENV=test db:migrate")
    end

    desc('Migrate development and test databases through scripts in db/migrate. Target specific version with VERSION=x.')
    task(:dt => :environment) do
      %w(development test).each do |e|
        puts("Migrating #{e} environment...")
        system("rake RAILS_ENV=#{e} db:migrate")
      end
    end

    namespace(:dt) do
      desc('Runs the "up" for a given migration VERSION in development and test enviroments.')
      task(:up => :environment) do
        %w(development test).each do |e|
          puts("Migrating UP #{e} environment...")
          system("rake RAILS_ENV=#{e} db:migrate:up")
        end
      end

      desc('Runs the "down" for a given migration VERSION in development and test enviroments.')
      task(:down => :environment) do
        %w(development test).each do |e|
          puts("Migrating DOWN #{e} environment...")
          system("rake RAILS_ENV=#{e} db:migrate:down")
        end
      end

      desc('Rollbacks the database one migration and re migrate up in development and test enviroments.')
      task(:redo => :environment) do
        %w(development test).each do |e|
          puts("Re migrating #{e} environment...")
          system("rake RAILS_ENV=#{e} db:migrate:redo")
        end
      end

      desc('Resets your database using your migrations for the development and test enviroments.')
      task(:reset => :environment) do
        %w(development test).each do |e|
          puts("Reset Migration #{e} environment...")
          system("rake RAILS_ENV=#{e} db:migrate:reset")
        end
      end
    end
  end
end
