module ControllerHelpers
  def sign_in(admin = double("admin"))
    allow(controller).to receive(:current_administrator).and_return(admin)
  end
end
