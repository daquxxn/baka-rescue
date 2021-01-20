using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class SteamState : ACharacterState
{

    #region Fields
    private float _timeStamp = 0f;
    #endregion Fields

    #region Properties
    #endregion Properties

    #region Methods
    public override void EnterState()
    {
        LinkEvents();
        _timeStamp = 0f;
    }

    public override void UpdateState()
    {
        _timeStamp += Time.deltaTime;
        if(_timeStamp >= _controller.SteamTime)
        {
            DisableSteam();
        }
        _controller.SteamMove();
    }

    public override void ExitState()
    {
        UnlinkEvents();
        _timeStamp = 0f;
    }

    private void DisableSteam()
    {
        _controller.ChangeState(ECharacterState.FALL);
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
