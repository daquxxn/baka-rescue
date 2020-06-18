using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class DoubleLevers : MonoBehaviour
{
    [SerializeField] private GameObject _wallLever = null;
    [SerializeField] private ChildLever _childLever1 = null;
    [SerializeField] private ChildLever _childLever2 = null;

    [SerializeField] private Transform _lucioles = null;
    [SerializeField] private Transform _posLevier = null;
    [SerializeField] private GameObject _fruitElec1 = null;
    [SerializeField] private GameObject _fruitElec2 = null;
    [SerializeField] private GameObject _fruitPasElec1 = null;
    [SerializeField] private GameObject _fruitPasElec2 = null;


    private AudioSource _destroyLeverSound;

    private void Start()
    {
        _destroyLeverSound = GetComponent<AudioSource>();
    }

    private void Update()
    {
        if(_childLever1.IsElectrified == true && _childLever2.IsElectrified == true)
        {
            _destroyLeverSound.Play();
            Destroy(_wallLever);
           float step = 10 * Time.deltaTime;
           _lucioles.transform.position = Vector3.MoveTowards(_lucioles.position, _posLevier.position, step);
            _fruitPasElec1.gameObject.SetActive(false);
            _fruitPasElec2.gameObject.SetActive(false);
            _fruitElec1.gameObject.SetActive(true);
            _fruitElec2.gameObject.SetActive(true);
        }
    }
}
