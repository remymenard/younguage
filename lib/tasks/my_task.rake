namespace :db do
  task :seeds_opt do
    puts `rails runner db/seeds_opt.rb `
  end
end
