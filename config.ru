require './config/environment'


use Rack::MethodOverride
use SentencesController
use UsersController
run ApplicationController
