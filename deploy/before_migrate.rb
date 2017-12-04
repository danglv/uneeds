node[:deploy].each do
  rails_env = new_resource.environment["RAILS_ENV"]
  current_path = release_path

  Chef::Log.info("Precompiling Rails assets with environment #{rails_env}")

  execute "rake assets:precompile" do
    user "deploy"
    cwd current_path
    command "bundle exec rake assets:precompile"
    environment "RAILS_ENV" => rails_env
  end
end
