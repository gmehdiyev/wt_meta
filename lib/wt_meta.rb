require "wt_meta/version"

module WtMeta
end

require 'wt_meta/wt_meta'
require 'wt_meta/view_helper'


ActionView::Base.send :include, WtMeta::ViewHelper