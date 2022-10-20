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

  def test_reject_unknown_tag_build
    assert_raises(RuntimeError) { HexletCode::Tag.build("unknown") }
  end

  def test_single_tag_build
    assert { HexletCode::Tag.build("img") == %(<img>) }
  end

  def test_single_tag_with_params_build
    assert { HexletCode::Tag.build("img", class: "my_class", src: "https://img.com") == %(<img class="my_class" src="https://img.com">) }
  end

  def test_double_tags_build
    assert { HexletCode::Tag.build("div") == %(<div></div>) }
  end

  def test_double_tags_with_params_build
    assert { HexletCode::Tag.build("div", class: "my_class") == %(<div class="my_class"></div>) }
  end

  def test_double_tags_with_block_build
    assert { HexletCode::Tag.build("div") { 23 } == %(<div>23</div>) }
  end
  
  def test_reject_unknown_second_args_build
    assert_raises(RuntimeError) { HexletCode::Tag.build("div", 1) }
  end

  def test_reject_not_given_block_form_for
    assert_raises(RuntimeError) { HexletCode.form_for @test_user }
  end

  def test_reject_not_exist_field_form_for
    assert_raises(NoMethodError) { HexletCode.form_for(@test_user) { |f| f.input :test } }
  end

  def test_with_empty_block_form_for
    form = HexletCode.form_for(@test_user) { }

    assert { form == %(<form action="#" method="POST"></form>) }
  end

  def test_with_simple_input_form_for
    form = HexletCode.form_for @test_user do |f|
      f.input :name
    end

    assert { form == %(<form action="#" method="POST"><input type="text" name="name" value="Nikita"></form>) }
  end

  def test_with_textarea_form_for
    form = HexletCode.form_for @test_user do |f|
      f.input :name
      f.input :surname, as: :text
    end

    assert { form == %(<form action="#" method="POST"><input type="text" name="name" value="Nikita"><textarea cols="50" rows="50" name="surname" value="Golubev"></textarea></form>) }
  end

  def test_form_params_form_for
    form = HexletCode.form_for @test_user, url: "hash" do |f|

    end

    assert { form == %(<form action="hash" method="POST"></form>) }
  end
end
