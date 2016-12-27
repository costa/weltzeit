class Signup < React::Component::Base
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
      ReactBootstrap::Button(bsStyle: 'primary', bsSize: 'large').sign do
        "Sign Up"
      end.on(:click) do
        open
      end
      ReactBootstrap::Modal(show: state.show_modal) do
        protected_form(action: '/users', method: :post) do
          ReactBootstrap::ModalHeader(closeButton: true) do
            ReactBootstrap::ModalTitle() do
              "Sign Up"
            end
          end
          ReactBootstrap::ModalBody() do
            H4 do
              "Provide your registration credentials please"
            end
            ReactBootstrap::ControlLabel() { "Email" }
            ReactBootstrap::FormControl(componentClass: :input, type: :email, name: 'user[email]', autoFocus: true)
            BR()
            ReactBootstrap::ControlLabel() { "Password" }
            ReactBootstrap::FormControl(componentClass: :input, type: :password, name: 'user[password]')
            BR()
            ReactBootstrap::ControlLabel() { "Password (again)" }
            ReactBootstrap::FormControl(componentClass: :input, type: :password, name: 'user[password_confirmation]')
          end
          ReactBootstrap::ModalFooter() do
            ReactBootstrap::Button() do
              "Close"
            end.on(:click) do
              close
            end
            ReactBootstrap::Button(type: :submit, bsStyle: 'primary') do
              "Register"
            end
          end
        end
      end.on(:hide) do
        close
      end
    end
  end
end
