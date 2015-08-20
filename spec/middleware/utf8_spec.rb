require 'spec_helper'

describe Utf8Sanitizer do

  let(:env_hash) do
     {
       "HTTP_REFERER" => "",
       "PATH_INFO" => "foo",
       "QUERY_STRING" => "?utf8=%E2%9C%93&works=all&works=%84",
       "REQUEST_PATH" => "is",
       "REQUEST_URI" => "here",
     }
   end

  subject do
    Utf8Sanitizer.new(env_hash)
  end

  context "when request handling a bad utf8 byte" do
      it "returns a status of 404" do
        subject.call(env_hash).should include (404)
      end
  end
end
