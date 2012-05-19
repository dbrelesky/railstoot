require 'spec_helper'

describe "UserPages" do
  
  before { visit signup_path }
  
  it 'should have H1 Sign Up' do
    page.should have_selector('h1', text:'Sign up')
  end
  
  it 'should have title Sign Up' do
    page.should have_selector('title', text:"Ruby on Rails Tutorial Sample App | Sign up")
  end

end
