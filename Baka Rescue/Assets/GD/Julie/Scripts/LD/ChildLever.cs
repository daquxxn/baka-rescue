using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ChildLever : MonoBehaviour
{
    private bool _isElectrified = false;

    public bool IsElectrified
    {
        get
        {
            return _isElectrified;
        }
    }

    private void OnTriggerStay(Collider other)
    {
        ElementalSurface elemSurface = other.GetComponent<ElementalSurface>();
        if(elemSurface != null && elemSurface.Element == EElement.THUNDER)
        {
            _isElectrified = true;
        }
        else
        {
            _isElectrified = false;
        }
    }
}
