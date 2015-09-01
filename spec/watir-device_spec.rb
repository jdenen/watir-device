require 'spec_helper'

describe Watir::WatirDevice do
  it 'has a version number' do
    expect(subject::VERSION).not_to be nil
  end
end
