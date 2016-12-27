class Signin < React::Component::Base
  include CsrfProtection

  define_state show_modal: false

  def close
    state.show_modal! false
  end

  def open
    state.show_modal! true
  end

  render do
    DIV do
      ReactBootstrap::Button().sign do
        "Sign In"
      end.on(:click) do
        open
      end
      ReactBootstrap::Modal(show: state.show_modal) do
        protected_form(action: '/users/sign_in', method: :post) do
          ReactBootstrap::ModalHeader(closeButton: true) do
            ReactBootstrap::ModalTitle() do
              "Sign In"
            end
          end
          ReactBootstrap::ModalBody() do
            H4 do
              "Type your credentials in please"
            end
            ReactBootstrap::ControlLabel() { "Email" }
            ReactBootstrap::FormControl(componentClass: :input, type: :email, name: 'user[email]', autoFocus: true)
            BR()
            ReactBootstrap::ControlLabel() { "Password" }
            ReactBootstrap::FormControl(componentClass: :input, type: :password, name: 'user[password]')
          end
          ReactBootstrap::ModalFooter() do
            ReactBootstrap::Button() do
              "Close"
            end.on(:click) do
              close
            end
            ReactBootstrap::Button(type: :submit, bsStyle: 'primary') do
              "Authenticate"
            end
          end
        end
      end.on(:hide) do
        close
      end
    end
  end
end
