using UnityEngine;

public class WalkState : ACharacterState
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
        _controller.Walk();
        if (_controller.MoveDir == Vector3.zero)
            _controller.ChangeState(ECharacterState.IDLE);
    }

    public override void ExitState()
    {
        UnlinkEvents();
    }

    private void Jump()
    {
        _controller.ChangeState(ECharacterState.JUMP);
    }

    #region Events
    private void LinkEvents()
    {
                //InputManager.Instance.JumpButtonPressed += Jump;
    }

    private void UnlinkEvents()
    {
                //InputManager.Instance.JumpButtonPressed -= Jump;
    }
    #endregion Events
    #endregion Methods
}
