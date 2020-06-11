using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class DamageFireSurface : MonoBehaviour
{
    [SerializeField] private int _damages = 1;

    public int Damages
    {
        get
        {
            return _damages;
        }
    }

}
