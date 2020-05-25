using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Lever : AElement
{
    [SerializeField] private Transform _wallLever = null;

    public override void ElementalReaction(EElement element)
    {

    }

    private void OnCollisionEnter(Collision collision)
    {
        if (_element == EElement.WATER)
        {
            Destroy(_wallLever);
        }
    }
   
}
