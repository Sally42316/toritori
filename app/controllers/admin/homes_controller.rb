class Admin::HomesController < ApplicationController
  def top
    @comments = Comment.all
  end
end
