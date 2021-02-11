
using UnityEngine;

public class IdleState : ACharacterState
{
    #region Fields
    #endregion Fields

    #region Properties
    #endregion Properties

    #region Methods
    public override void EnterState()
    {
        LinkEvents();
        _controller.RB.velocity = Vector3.zero;
    }

    public override void UpdateState()
    {
        if (_controller.MoveDir != Vector3.zero)
            _controller.ChangeState(ECharacterState.WALK);
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
        if (_controller.IsPlayerOne)
        {
            InputManager.Instance.OnJumpKeyOne += Jump;
            InputManager.Instance.SpellFire += _controller.SpellFire;
        }
        else
        {
            InputManager.Instance.OnJumpKeyTwo += Jump;
            InputManager.Instance.SpellWater += _controller.SpellWater;
        }
    }

    private void UnlinkEvents()
    {
        if (_controller.IsPlayerOne)
        {
            InputManager.Instance.OnJumpKeyOne -= Jump;
            InputManager.Instance.SpellFire -= _controller.SpellFire;
        }
        else
        {
            InputManager.Instance.OnJumpKeyTwo -= Jump;
            InputManager.Instance.SpellWater -= _controller.SpellWater;
        }
    }
    #endregion Events
    #endregion Methods
}
