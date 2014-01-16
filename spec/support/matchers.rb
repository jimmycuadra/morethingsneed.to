RSpec::Matchers.define(:a_string_matching) do |expected|
  match do |actual|
    actual =~ expected
  end
end
