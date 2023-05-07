class ApplicationController < ActionController::Base
  def current_user
    Session.new(iduff: '15626353798', iduff_personificado: nil, ip: '127.0.0.1')
  end
end
