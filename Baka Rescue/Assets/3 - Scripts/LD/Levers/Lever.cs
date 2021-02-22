﻿using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Lever : AElement
{
    [SerializeField] private GameObject _wallLever = null;
    /*[SerializeField] private Transform _lucioles = null;
    [SerializeField] private Transform _posLevier  = null;
    [SerializeField] private GameObject _fruitElec  = null;
    [SerializeField] private GameObject _fruitPasElec  = null;*/
    private bool _isFired = false;
    private bool _isWatered = false;

    [SerializeField] private bool _isFireLever = false;
    [SerializeField] private bool _isWaterLever = false;
    [SerializeField] private bool _isSteamLever = false;

    [SerializeField] private MovablePlateform _movplat = null;

    private void Start()
    {
    }

    private void Update()
    {
      /*  if (_isElectrified)
        {
            float step = 10 * Time.deltaTime;
            _lucioles.transform.position = Vector3.MoveTowards(_lucioles.position, _posLevier.position, step);
        }*/
    }
    public override void ElementalReaction(EElement element)
    {
        switch (element)
        {
            case EElement.FIRE:
               if (_element == EElement.NONE && _isFireLever == true)
                {
                    _isFired = true;
                    _movplat.Automatic = true;
                    Destroy(_wallLever);
                  // _fruitElec.gameObject.SetActive(true);
                  //  _fruitPasElec.gameObject.SetActive(false);
                }

                if (_element == EElement.NONE && _isSteamLever == true)
                {
                    _element = EElement.FIRE;
                }

                if (_element == EElement.WATER && _isSteamLever == true)
                {
                    Destroy(_wallLever);
                    _movplat.Automatic = true;
                }

                break;

            case EElement.WATER:
               if (_element == EElement.NONE && _isWaterLever == true)
                {
                    _isWatered = true;
                    Destroy(_wallLever);
                    _movplat.Automatic = true;
                    // _fruitElec.gameObject.SetActive(true);
                    //  _fruitPasElec.gameObject.SetActive(false);
                }

                if (_element == EElement.NONE && _isSteamLever == true)
                {
                    _element = EElement.WATER;
                }

                if (_element == EElement.FIRE && _isSteamLever == true)
                {
                    Destroy(_wallLever);
                    _movplat.Automatic = true;
                }

                break;

        }
    }

    private void OnTriggerEnter(Collider collider)
    {
        // Check if other is AElement
        AElement other = collider.GetComponent<AElement>();
        if (other != null )
        {
            // React with other's element
            ElementalReaction(other.Element);

            // Destroy other if it's a Projectile
            if (other is ElementalProjectile)
             Destroy(other.gameObject);
        }
    }
}
