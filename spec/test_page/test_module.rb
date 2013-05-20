module TestModule

  def foo?
    ENV['FOO'] == 'true'
  end

  def bar?
    ENV['BAR'] == 'true'
  end
end
