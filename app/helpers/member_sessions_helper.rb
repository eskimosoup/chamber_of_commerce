module MemberSessionsHelper
  def authenticate_member_session(member)
    session[:member_id] = member.id
  end

  def remember_member_session(member)
    member.member_login.generate_auth_token
    cookies.permanent.signed[:member_id] = member.id
    cookies.permanent[:member_auth_token] = member.auth_token
  end

  def logout_member_session(member)
    member.member_login.generate_auth_token
    cookies.delete(:member_id) if cookies.permanent.signed[:member_id]
    cookies.delete(:member_auth_token) if cookies.permanent[:member_auth_token]
    session[:member_id] = nil
  end

  def redirect_member_session
    return_to = root_url
    return_to = session[:return_to] if session[:return_to]
    return_to = root_url if blacklist_redirect_member_session.include?(return_to)
    session[:return_to] = nil
    return_to
  end

  def blacklist_redirect_member_session
    [authenticate_member_sessions_path,
     login_member_sessions_path,
     logout_member_sessions_path
    ]
  end
end
