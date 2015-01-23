module Firebase::Ext

  class Error < StandardError
  end

  module Writable
    extend ActiveSupport::Concern

    included do
      after_save :firebase_set
      after_destroy :firebase_reset
    end

    def firebase
      @firebase ||= Firebase::Client.new(ENV['FIREBASE_URL'])
    end


    def firebase_set
      firebase.set(firebase_path, as_json).tap do |response|
        raise Error, response.body  unless response.success?
      end
    end

    def firebase_reset
      firebase.set(firebase_path, nil).tap do |response|
        raise Error, response.body  unless response.success?
      end
    end

  end

end
