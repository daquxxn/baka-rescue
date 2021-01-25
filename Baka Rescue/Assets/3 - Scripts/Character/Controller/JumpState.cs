
using UnityEngine;

public class JumpState : ACharacterState
{
    #region Fields
    private bool _hasJumped = false;
    #endregion Fields

    #region Properties
    #endregion Properties

    #region Methods
    public override void EnterState()
    {
        _controller.Jump();
        LinkEvents();
    }

    public override void UpdateState()
    {
        _controller.AirControl();
        if (_controller.RB.velocity.y > 0 && !_hasJumped)
            _hasJumped = true;
        if (_controller.RB.velocity.y <= 0 && _hasJumped)
            _controller.ChangeState(ECharacterState.FALL);
    }

    public override void ExitState()
    {
        _hasJumped = false;
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
