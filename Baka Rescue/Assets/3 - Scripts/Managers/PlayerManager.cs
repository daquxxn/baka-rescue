using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using Zblah.Utils;

public class PlayerManager : Singleton<PlayerManager>
{
    private CharacController _charac = null;

    public CharacController Charac
    {
        get 
        {
            return _charac;
        }
        set
        {
            _charac = value;
        }
    }
    // Start is called before the first frame update
    protected override void Start()
    {
        base.Start();
    }
}
