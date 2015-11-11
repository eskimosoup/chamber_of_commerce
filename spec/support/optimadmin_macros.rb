module OptimadminMacros
  def login_to_admin_with(username, password)
    visit optimadmin.login_path
    expect(current_path).to eq(optimadmin.login_path)
    fill_in "Email or Username", with: username
    fill_in "Password", with: password
    click_button "Log In"
    expect(current_path).to eq(optimadmin.root_path)
    expect(page).to have_content("Logged in!")
  end

  def tiny_mce_fill_in(name, args)
    within_frame("#{name}_ifr") do
      editor = page.find_by_id('tinymce')
      editor.native.send_keys(args[:with])
    end
  end

  def current_host_and_port
    [Capybara.current_host, Capybara.current_session.server.port].compact.join(":")
  end
end