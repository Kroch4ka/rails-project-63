# frozen_string_literal: true

require "test_helper"

class TestHexletCode < Minitest::Test
  User = Struct.new(:name, :surname)

  def setup
    @test_user = User.new("Nikita", "Golubev")
  end

  def test_that_it_has_a_version_number
    refute_nil ::HexletCode::VERSION
  end

  def test_not_given_block_to_form_for_method
    assert_raises(RuntimeError) { HexletCode.form_for(@test_user) }
  end

  def test_given_form_tag
    assert { HexletCode.form_for(@test_user) {} == '<form action="#" method="post"></form>' }
  end

  def test_given_form_tag_with_url
    assert { HexletCode.form_for(@test_user, url: "test") {} == '<form action="test" method="post"></form>' }
  end
end
