using System;
using UnityEngine;

[Serializable]
public abstract class ACharacterState
{
    #region Fields
    protected ECharacterState _state = ECharacterState.IDLE;
    protected CharacterController _controller = null;
    #endregion Fields

    #region Properties
    public ECharacterState State => _state;
    #endregion Properties

    #region Methods
    public void Initialize(ECharacterState state, CharacterController controller)
    {
        _controller = controller;
        _state = state;
    }

    public abstract void EnterState();

    public abstract void UpdateState();

    public abstract void ExitState();
    #endregion Methods
}
