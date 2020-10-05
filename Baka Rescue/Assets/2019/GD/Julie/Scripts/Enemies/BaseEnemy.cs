using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class BaseEnemy : MonoBehaviour
{
    [SerializeField] protected int _damages = 1; 

    public int Damages
    {
        get
        {
            return _damages;
        }
    }

}
