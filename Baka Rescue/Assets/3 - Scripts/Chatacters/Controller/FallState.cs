
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
        if (_controller.IsPlayerOne)
        {
            InputManager.Instance.SpellFire += _controller.SpellFire;
            InputManager.Instance.TransFire += _controller.TransFire;
        }
        else
        {
            InputManager.Instance.SpellWater += _controller.SpellWater;
            InputManager.Instance.TransWater += _controller.TransWater;
        }
    }

    private void UnlinkEvents()
    {
        if (_controller.IsPlayerOne)
        {
            InputManager.Instance.SpellFire -= _controller.SpellFire;
            InputManager.Instance.TransFire -= _controller.TransFire;
        }
        else
        {
            InputManager.Instance.SpellWater -= _controller.SpellWater;
            InputManager.Instance.TransWater -= _controller.TransWater;
        }
    }
    #endregion Events
    #endregion Methods
}
