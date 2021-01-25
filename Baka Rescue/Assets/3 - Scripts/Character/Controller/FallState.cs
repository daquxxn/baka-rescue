
using UnityEngine;

public class FallState : ACharacterState
{
    #region Fields
    #endregion Fields

    #region Properties
    #endregion Properties

    #region Methods
    public override void EnterState()
    {
        LinkEvents();
    }

    public override void UpdateState()
    {
        _controller.AirControl();
        if (_controller.IsGrounded)
            _controller.ChangeState(ECharacterState.WALK);
    }

    public override void ExitState()
    {
        UnlinkEvents();
    }

    #region Events
    private void LinkEvents()
    {
    }

    private void UnlinkEvents()
    {
    }
    #endregion Events
    #endregion Methods
}
