require 'spec_helper'

require_relative '../lib/calcvariation.rb'

describe 'Calcvarition' do
  let(:initial_value) {35}
  let(:final_value) {120}
  let(:variation) {
        CalcVariation.new(initial_value,final_value)
          }
  it 'returns procentual variation' do
    expect(variation.percentual).to eq(242.86)
  end
end
