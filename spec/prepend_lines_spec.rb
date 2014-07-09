require 'spec_helper'
require 'fileutils'

describe 'prepend-lines executable' do
  before do
    @file_path_one = 'spec/files/one.html'
    @file_path_two = 'spec/files/two.html'
    @file_one_text = <<-RESULT1
      <h1>foo heading</h1>
      <p>foo paragraph</p>
      <p>foo paragraph</p>
      </body>
      </html>
      RESULT1
    @file_two_text = <<-RESULT2
      <h1>bar heading</h1>
      <p>bar paragraph</p>
      <p>bar paragraph</p>
      </body>
      </html>
      RESULT2
    File.write(@file_path_one, @file_one_text)
    File.write(@file_path_two, @file_two_text)
  end

  it 'prepends lines from a given file to the begining of specified files' do
    system './bin/prepend-lines', 'spec/files/header-info.html', @file_path_one,
      @file_path_two

    result_1 = File.read('spec/files/header-info.html') + (@file_one_text)
    result_2 = File.read('spec/files/header-info.html') + (@file_two_text)

    expect(File.read(@file_path_one)).to eq(result_1)
    expect(File.read(@file_path_two)).to eq(result_2)
  end

  after do
    FileUtils.rm [@file_path_one, @file_path_two], force: true
  end
end
