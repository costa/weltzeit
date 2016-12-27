class Signout < React::Component::Base
  include CsrfProtection

  render do
    DIV.sign do
      protected_form(action: '/users/sign_out', method: :post) do
        INPUT(type: :hidden, name: :_method, value: :delete)
        ReactBootstrap::Button(type: :submit, bsStyle: 'link', bsSize: 'small').sign do
          "Sign Out"
        end
      end
    end
  end
end
