using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class DoubleLevers : MonoBehaviour
{
    [SerializeField] private GameObject _wallLever = null;
    [SerializeField] private ChildLever _childLever1 = null;
    [SerializeField] private ChildLever _childLever2 = null;

    private void Update()
    {
        if(_childLever1.IsElectrified == true && _childLever2.IsElectrified == true)
        {
            Destroy(_wallLever);
        }
    }
}
