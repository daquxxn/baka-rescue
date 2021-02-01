using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Collectibles : MonoBehaviour
{
    [SerializeField] private int _lifeHealed = 20;

    public int LifeHealed
    {
        get
        { return _lifeHealed; }
      
    }
}
