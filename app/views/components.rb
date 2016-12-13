require 'opal'
require 'webpack/client_and_server.js'
require 'hyper-react'
require 'reactrb/auto-import'
if React::IsomorphicHelpers.on_opal_client?
  require 'opal-jquery'
  require 'browser'
  require 'browser/interval'
  require 'browser/delay'
  # add any additional requires that can ONLY run on client here
end
require 'hyper-router'
require 'react_router'
require 'hyper-mesh'
require 'models'
require_tree './components'
