require "test_helper"

class MembershipTest < ActiveSupport::TestCase
  def setup
    super
    @user = FactoryBot.create(:onboarded_user)
    @application = FactoryBot.create(:platform_application, team: @user.current_team)
    @platform_membership = Membership.find_by(platform_agent_of_id: @application.id)
  end

  test "should not be tombstoned if membership is a platform agent with nil user_id" do
    assert @platform_membership.platform_agent_of_id.present?
    @platform_membership.nullify_user
    assert_nil @platform_membership.user_id
    refute @platform_membership.tombstone?
  end
end
