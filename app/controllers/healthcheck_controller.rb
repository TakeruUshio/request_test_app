class HealthcheckController < ApplicationController

  VERSION = File.exist?(Rails.root.join("VERSION").to_s) ? File.read(Rails.root.join("VERSION").to_s).strip : 'no_version'

  def show_version
    render json: {version: VERSION}
  end

  def show_env
    # sort by key
    render json: ENV.keys.sort.each_with_object({}){|k,d| d[k] = ENV[k]}
  end

end
